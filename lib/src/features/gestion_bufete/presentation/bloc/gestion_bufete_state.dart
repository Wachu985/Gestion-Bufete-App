part of 'gestion_bufete_bloc.dart';

enum ContratoStatus { initial, loading, success, error }

class GestionBufeteState extends Equatable {
  final Map<dynamic, Contrato> contratos;
  final double total;
  final ContratoStatus status;

  const GestionBufeteState(
      {this.contratos = const {},
      this.total = 0,
      this.status = ContratoStatus.initial});

  factory GestionBufeteState.initalState() => const GestionBufeteState();

  GestionBufeteState copyWith(
          {Map<dynamic, Contrato>? contratos,
          double? total,
          ContratoStatus? status}) =>
      GestionBufeteState(
          contratos: contratos ?? this.contratos,
          status: status ?? this.status,
          total: total ?? this.total);

  @override
  List<Object> get props => [contratos, total, status];
}

// abstract class GestionBufeteState extends Equatable {
//   const GestionBufeteState();

//   @override
//   List<Object> get props => [];
// }