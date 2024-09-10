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
    Web3Client _web3client;
    late ContractAbi _abiCode;
    late EthereumAddress _contractAddress;
    late EthPrivateKey _creds;

    // contract function
    late ContractFunction _deposit;
    late ContractFunction _withdraw;
    late ContractFunction _getBalance;
    late ContractFunction _getAllTransactions;
    on<DashboardInitialFetch>((event, emit) async {
      final String rpcurl = "http://127.0.0.1:7545";
      final String socketurl = "ws://127.0.0.1:7545";
      final String privateKey =
          "0xc3e8225381adc993d77bc0707587c1898221b8a84caef8e60d85406971aefec4";
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

      _contractAddress =
          EthereumAddress.fromHex(jsonDecoded["networks"]["5777"]["address"]);

      _creds = EthPrivateKey.fromHex(privateKey);
    });
  }
}
