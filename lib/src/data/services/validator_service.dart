mixin ValidatorService {
  String? validateGameSected(String? gameSelected) {
    if (gameSelected == null || gameSelected.isEmpty) {
      return 'Selecione um game';
    }

    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Campo obrigatório';
    }

    if (name.length <= 2) {
      return 'Esse campo precisa ter no mínimo 3 caracteres';
    }

    return null;
  }

  String? validateYearsGameTime(String? yearsGameTime) {
    if (yearsGameTime == null || yearsGameTime.isEmpty) {
      return 'Campo obrigatório';
    }

    if (yearsGameTime.length > 2) {
      return 'Valor inválido';
    }

    try {
      int.tryParse(yearsGameTime);
    } catch (e) {
      return 'Informe um valor numérico';
    }

    return null;
  }  

  String? validateDiscord(String? discord) {
    if (discord == null || discord.isEmpty) {
      return 'Campo obrigatório';
    }
    
    if (discord.length <= 2) {
      return 'Esse campo precisa ter no mínimo 2 caracteres';
    }

    return null;
  }

  String? validateDaysAvailability(List<bool> selectedDays) {
    if (!selectedDays.contains(true)) {
      return 'Escolha pelo menos um dia';
    }

    return null;
  }

  String? validateHourAvailability(String? hourAvailability) {
    if (hourAvailability == null || hourAvailability.isEmpty) {
      return 'Campo obrigatório';
    }

    if (hourAvailability.length > 2) {
      return 'Informe um horário como: 10, 22, 13...';
    }

    try {
      int.tryParse(hourAvailability);
    } catch (e) {
      return 'Informe apenas valores numéricos';
    }

    return null;
  }
}