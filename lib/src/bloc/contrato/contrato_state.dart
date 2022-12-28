part of 'contrato_bloc.dart';

abstract class ContratoState extends Equatable {
  final Map<dynamic, Contrato>? contratos;
  final double total;
  const ContratoState({this.contratos, required this.total});

  @override
  List<Object> get props => [];
}

class ContratoInitial extends ContratoState {
  const ContratoInitial() : super(contratos: null, total: 0);
}

class ContratoLoadingState extends ContratoState {
  const ContratoLoadingState() : super(contratos: null, total: 0);
}

class ContratoSuccessState extends ContratoState {
  final Map<dynamic, Contrato> newContratos;
  final double newTotal;
  const ContratoSuccessState(this.newContratos, this.newTotal)
      : super(contratos: newContratos, total: newTotal);
}
