From: Pieter Palmers <ppalmers@esat.kuleuven.ac.be>
Subject: Re: Firewire Audio Card Support
Date: Thu, 18 Nov 2004 19:54:58 +0000
Message-ID: <419CFE12.1070908@esat.kuleuven.ac.be>
References: <31148074.1100630541337.JavaMail.root@scooter.psp.pas.earthlink.net> <419C9D47.4090606@x-i.net> <200411181515.52218.olaf@solutionworks.de> <20041118143205.GA21282@login.ecs.soton.ac.uk> <419CB554.3080709@esitcom.org> <Pine.LNX.4.58.0411181601440.14962@denise.shiny.it> <419CBCAB.6040409@esitcom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <419CBCAB.6040409@esitcom.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Amaury Jacquot <sxpert@esitcom.org>
Cc: linux-audio-user@music.columbia.edu, linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Amaury Jacquot wrote:

> Giuliano Pochini wrote:
>
>>
>> No, it's not hard because there are a lot of skilled people around, but
>> the card would be expensive. There was a thread about a project of "open
>> source" graphic card recently on lkml.
>
>
> I know about the project in question, as I participate in the 
> discussion about it.
> an open design sound card would be even easier to design... an atmel 
> microcontroller and a pair of ADC / DAC chips should be enough to 
> desing something with a USB port.
> now for the firewire thing, I guess a xilinx chip can do it, and those 
> are not that expensive either...

I don't think it's possible to obtain the same price vs performance with 
a self-developed device. The skills won't be a problem indeed, but as 
most of us  are doing this in our spare time, I don't think we'll find 
the time to keep up with commercial specs. But the major problem would 
be the manufacturing cost as we won't have the mass-production benefits 
commercial companies have.

Why don't we support the manufacturers that do support us? After all, 
there are some that provide us with what we need, and I don't see that 
mentioned that often. I'm quite confident that for most needs you can 
find a card from a manufacturer that supports ALSA development. Correct 
me if I'm wrong, but I got the impression that for example RME and ESI 
actively support the development of ALSA drivers for their producs.

It might be more usefull to compile a list of Linux-friendly 
manufacturers and make some noise about such a list. This might be 
something for the linuxaudio.org people?

Greets,

Pieter Palmers


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
