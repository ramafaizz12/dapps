import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dapps/models/transaction_model.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {});
    List<TransactionModel> transactions = [];
    Web3Client? _web3client;
    late ContractAbi _abiCode;
    late EthereumAddress _contractAddress;
    late EthPrivateKey _creds;
    int balance;

    // contract function
    late DeployedContract _deployedContract;
    late ContractFunction _deposit;
    late ContractFunction _withdraw;
    late ContractFunction _getBalance;
    late ContractFunction _getAllTransactions;
    on<DashboardInitialFetch>((event, emit) async {
      const String rpcurl = "http://192.168.1.6:7545";
      const String socketurl = "ws://192.168.1.6:7545";
      const String privateKey =
          "0xc3e8225381adc993d77bc0707587c1898221b8a84caef8e60d85406971aefec4";
      try {
        emit(DashboardLoading());

        _web3client = Web3Client(
          rpcurl,
          http.Client(),
          socketConnector: () {
            return IOWebSocketChannel.connect(socketurl).cast<String>();
          },
        );
        String abiFile = await rootBundle
            .loadString('build/contracts/ExpenseManagerContract.json');
        var jsonDecoded = jsonDecode(abiFile);
        _abiCode = ContractAbi.fromJson(
            jsonEncode(jsonDecoded['abi']), 'ExpenseManagerContract');

        _contractAddress = EthereumAddress.fromHex(
            "0xB779C73A05cBea57Ece7Ad599e2E9e9ff00fD4ae");

        _creds = EthPrivateKey.fromHex(privateKey);

        // get smart contract
        _deployedContract = DeployedContract(_abiCode, _contractAddress);
        _deposit = _deployedContract.function("deposit");
        _withdraw = _deployedContract.function("withdraw");
        _getBalance = _deployedContract.function("getBalance");
        _getAllTransactions = _deployedContract.function("getAllTransaction");

        final transactiondata = await _web3client!.call(
            contract: _deployedContract,
            function: _getAllTransactions,
            params: []);
        final balanceData = await _web3client!
            .call(contract: _deployedContract, function: _getBalance, params: [
          EthereumAddress.fromHex("0xD4C6B01Eb42Ee266fc79cC280e438B1714165ACD")
        ]);
        List<TransactionModel> trans = [];
        for (int i = 0; i < transactiondata[0].length; i++) {
          TransactionModel transactionModel = TransactionModel(
              transactiondata[0][i].toString(),
              transactiondata[1][i].toInt(),
              transactiondata[2][i],
              DateTime.fromMicrosecondsSinceEpoch(
                  transactiondata[3][i].toInt()));
          trans.add(transactionModel);
        }
        transactions = trans;

        int bal = balanceData[0].toInt();
        balance = bal;

        emit(DashboardSucces(transactions: transactions, balance: balance));
        print(transactiondata + balanceData);
      } catch (e) {
        print(e.toString());
        emit(DashboardError());
      }
    });

    on<DashboardDepositEvent>((event, emit) async {
      var data = await _web3client!.call(
          contract: _deployedContract,
          function: _deposit,
          params: [
            event.transactionmodel.amount,
            event.transactionmodel.reason
          ]);
    });
    on<DashboardWithdrawEvent>((event, emit) async {
      var data = await _web3client!.call(
          contract: _deployedContract,
          function: _withdraw,
          params: [
            event.transactionmodel.amount,
            event.transactionmodel.reason
          ]);
    });
  }
}
