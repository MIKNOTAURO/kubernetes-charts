local := http:\/\/127.0.0.1:8879\/charts
remote := https:\/\/raw.githubusercontent.com\/APSL\/kubernetes-charts\/master\/packages

helm-up:
	helm serve

helm-packages:
	for x in */requirements.*; do sed -i -e "s/${remote}/${local}/g" $$x; done
	for x in */Chart.yaml; do helm package -u -d packages $$(dirname $$x); done
	for x in */requirements.*; do sed -i -e "s/${local}/${remote}/g" $$x; done

helm-index:
	helm repo index packages