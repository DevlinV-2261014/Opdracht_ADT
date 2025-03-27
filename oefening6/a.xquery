for $p in distinct-values(doc("patients.xml")//patient/name),
    $d in distinct-values(doc("diseases.xml")//disease/name)
let $patientSymptoms := doc("patients.xml")//patient[name = $p]/symptom
let $diseaseSymptoms := doc("diseases.xml")//disease[name = $d]/symptom
where every $sym in $diseaseSymptoms satisfies $sym = $patientSymptoms
return 
    <match>
        <patient>{ $p }</patient>
        <disease>{ $d }</disease>
    </match>
