***Projeto Prometheus***

Olá, esse projeto te instruirá e irá preparar seu ambiente para subir um ambiente de monitoramento usando o serviço do **Prometheus** como o "BackEnd" que irá coletar as métricas através de uma consulta **PromQL**, dados dos quais serão visualizados através do **Grafana**.

Vale Lembrar que esse projeto e Shells irão preparar o seu ambiente, o que claramente não significa que ele estará pronto para entrar em produção, aonde toda a parte de parametrização estará a disposição de quem for utilizá-lo.


***Serviços Fundamentais para que essa ambiente funcione:***

-Prometheus;
-Grafana;
-Node Exporter;
-WMI Exporter;


**Prometheus**

O Prometheus irá coletar as métricas dos hosts que você deseja monitorar, aqui em nosso ambiente, por meio do .sh todo o ambiente está sendo preparado em um Ubuntu Server (24.04.1 LTS). 
**Detalhe Importante** = O Prometheus roda por meio da porta 9090 e por isso é extremamente importante garantir a segurança e o devido monitoramento correto dessa porta.


**Grafana**

O Grafana irá ser necessário para visualizar as métricas coletadas, é importante garantir que os dados exibidos sejam condizentes com o objetivo do cliente/negócio que está contratando seu serviço.
**Detalhe Importante** = O Grafana roda por meio da porta 3000 e por isso é extremamente importante garantir a segurança e o devido monitoramento correto da porta.
**Login padrão Grafana** = admin / admin


**Node Exporter**

O Node Exporter é uma ferramenta para coleta de métricas nos hosts, focada para Linux e MACOS. Ele irá liberar a coleta de métricas em um host do qual serão posteriormente atrelados ao Prometheus por meios dos *targets*.
**Detalhe Importante** = O Node Exporter roda por meio da porta 9100 da Estação e por isso é extremamente importante garantir a segurança e o devido monitoramento correto da porta.


**WMI Exporter**
O Node Exporter é uma ferramenta para coleta de métricas nos hosts, focada para Windows e Windows Server. Ele irá liberar a coleta de métricas em um host do qual serão posteriormente atrelados ao Prometheus por meios dos *targets*.
**Detalhe Importante** = O Node Exporter roda por meio da porta 9181 da Estação e por isso é extremamente importante garantir a segurança e o devido monitoramento correto da porta.

Obrigado,
Second, Lucas.
