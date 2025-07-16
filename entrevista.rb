require 'date'

class Entrevista
  def initialize
    pedir_nombre
    pedir_fecha_nacimiento
    pedir_pais
    pedir_datos_fisicos
  end

  def pedir_nombre
    print 'Escribe tu nombre: '
    @nombre = gets.chomp
    puts "Hola, #{@nombre}."
  end

  def pedir_fecha_nacimiento
    print '¿Cuándo naciste? (formato: DD-MM-YYYY): '
    fecha_str = gets.chomp
    begin
      fecha_nacimiento = Date.strptime(fecha_str, '%d-%m-%Y')
    rescue ArgumentError
      puts "Formato inválido. Usa DD-MM-YYYY."
      return pedir_fecha_nacimiento
    end

    edad = calcular_edad(fecha_nacimiento)
    signo = obtener_signo_zodiacal(fecha_nacimiento.day, fecha_nacimiento.month)

    puts "Tienes #{edad} años."
    puts "Tu signo zodiacal es: #{signo}"
  end

  def calcular_edad(fecha_nacimiento)
    hoy = Date.today
    edad = hoy.year - fecha_nacimiento.year
    edad -= 1 if Date.new(hoy.year, fecha_nacimiento.month, fecha_nacimiento.day) > hoy
    edad
  end

  def obtener_signo_zodiacal(dia, mes)
    case mes
    when 1 then dia < 20 ? 'Capricornio' : 'Acuario'
    when 2 then dia < 19 ? 'Acuario' : 'Piscis'
    when 3 then dia < 21 ? 'Piscis' : 'Aries'
    when 4 then dia < 20 ? 'Aries' : 'Tauro'
    when 5 then dia < 21 ? 'Tauro' : 'Géminis'
    when 6 then dia < 21 ? 'Géminis' : 'Cáncer'
    when 7 then dia < 23 ? 'Cáncer' : 'Leo'
    when 8 then dia < 23 ? 'Leo' : 'Virgo'
    when 9 then dia < 23 ? 'Virgo' : 'Libra'
    when 10 then dia < 23 ? 'Libra' : 'Escorpio'
    when 11 then dia < 22 ? 'Escorpio' : 'Sagitario'
    when 12 then dia < 22 ? 'Sagitario' : 'Capricornio'
    else 'Desconocido'
    end
  end

  def pedir_pais
    print '¿En qué país vives?: '
    pais = gets.chomp.downcase

    mensaje = case pais
              when 'perú' then '¡Tierra del imperio Inca y Machu Picchu!'
              when 'méxico' then '¡Cuna de civilizaciones antiguas y del mariachi!'
              when 'argentina' then '¡El tango, el asado y Maradona!'
              when 'españa' then '¡Flamenco, paella y arquitectura impresionante!'
              when 'japón' then '¡Tecnología, anime y cerezos en flor!'
              else '¡Un país maravilloso con mucho por descubrir!'
              end

    puts mensaje
  end

  def pedir_datos_fisicos
    print '¿Cuál es tu peso en kilogramos? (ej. 70): '
    peso = gets.chomp.to_f
    print '¿Cuál es tu estatura en metros? (ej. 1.70): '
    estatura = gets.chomp.to_f

    if estatura <= 0
      puts "Estatura inválida. No se puede calcular el IMC."
      return
    end

    imc = (peso / (estatura ** 2)).round(2)
    puts "Tu IMC es: #{imc}"

    case imc
    when 0...18.5
      peso_minimo = (18.5 * estatura**2).round(1)
      diferencia = (peso_minimo - peso).round(1)
      puts "Tienes bajo peso. Te faltan #{diferencia} kg para alcanzar el peso saludable mínimo."
    when 18.5..24.9
      puts "¡Estás en un peso saludable! Mantente así 💪"
    when 25..29.9
      peso_maximo = (24.9 * estatura**2).round(1)
      diferencia = (peso - peso_maximo).round(1)
      puts "Tienes sobrepeso. Deberías perder aproximadamente #{diferencia} kg para alcanzar el límite saludable."
    else
      peso_maximo = (24.9 * estatura**2).round(1)
      diferencia = (peso - peso_maximo).round(1)
      puts "Tienes obesidad. Deberías perder aproximadamente #{diferencia} kg para alcanzar un peso saludable."
    end
  end
end

Entrevista.new
