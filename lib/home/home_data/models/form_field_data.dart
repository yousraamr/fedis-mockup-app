class FormFieldData {
  final String? id;
  final String? label;
  final String? name;
  final String? type;
  final bool? readOnly;
  final int? minLength;
  final int? maxLength;
  final int? lg;
  final int? md;
  final String? dataFromKey;
  final String? condition;
  final String? stepTitle;
  final String? action;
  final bool? arrow;
  final bool? bottom;
  final String? color;

  final bool? required;
  final String? validationMessage;
  final String? regex;

  FormFieldData({
    this.id,
    this.label,
    this.name,
    this.type,
    this.readOnly,
    this.minLength,
    this.maxLength,
    this.lg,
    this.md,
    this.dataFromKey,
    this.condition,
    this.stepTitle,
    this.action,
    this.arrow,
    this.bottom,
    this.color,

    this.required,
    this.validationMessage,
    this.regex,
  });

  factory FormFieldData.fromJson(Map<String, dynamic> json) => FormFieldData(
    id: json['id'],
    label: json['label'],
    name: json['name'],
    type: json['type'],
    readOnly: json['readOnly'],
    minLength: json['minLength'],
    maxLength: json['maxLength'],
    lg: json['lg'],
    md: json['md'],
    dataFromKey: json['dataFromKey'],
    condition: json['condition'],
    stepTitle: json['stepTitle'],
    action: json['action'],
    arrow: json['arrow'],
    bottom: json['bottom'],
    color: json['color'],

    required: json['required'],
    validationMessage: json['validationMessage'],
    regex: json['regex'],
  );
}