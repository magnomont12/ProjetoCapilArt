//
//  ViewController.swift
//  projetoCapilArt
//
//  Created by Aluno on 20/06/2018.
//  Copyright © 2018 aluno. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var teste: UITextView!
    @IBOutlet weak var image: UIImageView!
    let speechSynthesizer = AVSpeechSynthesizer()
    var motion = CMMotionManager()
    var contador = 3
    var falando = false
    var textoAparece = true
    var mudarTela = true
    var poemas = ["""
    Essa tua indecisão
    Rasga fundo o meu peito
    Fazendo uma cisão
    Que não te faz efeito
    
    Sempre que eu me declarava
    Você confusa dizia "sei não”
    Meu estômago embrulhava
    Sentia um aperto no coração
    
    Desde o início fomos assim
    Você nunca tomava uma decisão
    Nunca me dizia que sim
    Mas também não dizia que não
    
    Sempre fui tão decidido
    Mas fins me deixam perdido
    Você não foi a primeira
    Já sou veterano nessa brincadeira
    
    Mas não se importe, meu bem
    Não liga pra essa minha dor no peito
    Ao fim eu sempre dou meu jeito
    Já refeito, vou procurar o meu próprio bem
    
    Sei que teu corpo já é de outro
    Que te deu novas sensações
    Te apresentou novas canções
    Beijou tua boca, te fez declarações
    Nem preciso dizer que isso dói
    É meu sentimentalismo que destrói
    Toda e qualquer possibilidade
    De você me dizer “tô com saudade”
    
    Mas só vou parar de te escrever
    Quando você me aparecer
    E dizer que até achou muito lindo
    Mas que todo bom amor é findo
""", """
Vou ouvir sua voz rouca
        Implorando para que tire sua roupa
        Pra te levar pro céu da boca
        
        Subirei até estratosfera
        Depois de criar nossa atmosfera
        Descerei sua calcinha amarela
        Com tempo pra admirar as estampas dela
        
        Todas os planetas, galáxias, constelações
        Tornam-se grandes provocações
        E me deixam com uma vontade louca
        De me perder contigo nesse céu da boca
""", """
Então…
Coragem!
O amor é um lobo selvagem
Covarde, perde-se'e'morre
Some tudo em ventania
Perdão…
Escolhe!
Beije-me com vontade
O que hoje é monotonia
Amanhã já é saudade

"""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        teste.text = poemas[0]
        if Reachability.isConnectedToNetwork(){
            let myProfilePictureURL = NSURL(string: "https://t2.uc.ltmcdn.com/pt/images/0/8/8/img_como_fazer_um_gato_aprender_seu_nome_17880_600.jpg")
            let imageData = NSData(contentsOf: myProfilePictureURL! as URL)
            self.image.image = UIImage(data: imageData! as Data)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.motion.accelerometerUpdateInterval = 0.2
        motion.startAccelerometerUpdates(to: OperationQueue.current!){
            (data , error) in
            
            if let trueData = data {
                if ((trueData.acceleration.x >= 5 || trueData.acceleration.x <= -5) && (self.mudarTela == true)){
                    self.mudarImagem()
                    self.mudarTela = true
                }
                else{
                    self.mudarTela = false
                }
            }
        }
    }
    
    @IBAction func escutarTexto(_ sender: Any) {
        let speechUtterance = AVSpeechUtterance(string: teste.text!)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "pt-BR");
        if(falando == false){
                speechSynthesizer.speak(speechUtterance)
            falando=true
            print("Entrei aqui")
        }
        else{
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.word)
            falando = false
        }
        
    }
    
    @IBAction func esconderTexto(_ sender: Any) {
        textoAparece = !textoAparece
        if(textoAparece == true){
            mudarTexto()
        }
        else{
            teste.text = ""
        }
    }
    
    @IBAction func Direita(_ sender: Any) {
        contador = contador + 1
       mudarTexto()
        mudarImagem()
        if(falando == true)
        {
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.word)
            falando = false
        }
    }
    
    @IBAction func Esquerda(_ sender: Any) {
        contador = contador - 1
        if(contador < 3){
            contador = 5
        }
       mudarTexto()
       mudarImagem()
        if(falando == true)
        {
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.word)
            falando = false
        }
    }
    
    func mudarTexto(){
        if(contador % 3 == 0 && textoAparece == true){
            teste.text = poemas[0]
        }
        else if(contador % 3 == 1 && textoAparece == true){
            teste.text = poemas[1]
        }
        else if(contador % 3 == 2 && textoAparece == true){
            teste.text = poemas[2]
        }
    }
    
    func mudarImagem(){
        if Reachability.isConnectedToNetwork(){
            if(contador % 3 == 0 && textoAparece == true){
                let myProfilePictureURL = NSURL(string: "https://t2.uc.ltmcdn.com/pt/images/0/8/8/img_como_fazer_um_gato_aprender_seu_nome_17880_600.jpg")
                let imageData = NSData(contentsOf: myProfilePictureURL! as URL)
                self.image.image = UIImage(data: imageData! as Data)
            }
            else if(contador % 3 == 1 && textoAparece == true){
                let myProfilePictureURL = NSURL(string: "https://i0.wp.com/www.bmmua.com/wp-content/uploads/2012/05/tumblr_m4asqkNIfR1qafc06o1_500.jpg")
                let imageData = NSData(contentsOf: myProfilePictureURL! as URL)
                self.image.image = UIImage(data: imageData! as Data)
            }
            else if(contador % 3 == 2 && textoAparece == true){
                let myProfilePictureURL = NSURL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAKwU3uUXTyzBHsRuZ9pxJuaYMUhadLII43UM-m6R0non1SJhT")
                let imageData = NSData(contentsOf: myProfilePictureURL! as URL)
                self.image.image = UIImage(data: imageData! as Data)
            }
        }
    }
}

