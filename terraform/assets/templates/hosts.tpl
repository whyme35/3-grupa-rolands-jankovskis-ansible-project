[servers]
%{ for dns in servers ~}
${dns}
%{ endfor ~}

[webservers]
%{ for dns in webservers ~}
${dns}
%{ endfor ~}

[database]
%{ for dns in database ~}
${dns}
%{ endfor ~}