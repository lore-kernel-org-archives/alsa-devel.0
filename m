From: Martin Langer <martin-langer@gmx.de>
Subject: Re: MIDI+USB - one way?
Date: Sat, 3 Aug 2002 02:21:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020803002119.GD1372@tuba.home>
References: <20020802001554.48f2f13a.mis@creazone.com> <3D4ABCA6.9E126597@ladisch.de> <3D4AD766.4030908@boosthardware.com> <200208030128.53390.plcl@telefonica.net>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200208030128.53390.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 03, 2002 at 01:28:52AM +0200, Pedro Lopez-Cabanillas wrote:
> 
> As a side note, the name "card" is not very appropiate in the USB land. They 
> are all external devices, (MIDI adaptors, keyboards, drum controllers and 
> surely soon guitars, wind controllers, etc.), connected by the USB cable to 
> the computer or USB hub. Another surprising issue is that in the ALSA 
> soundcard matrix there is no one Roland/Edirol device. The snd-usb-driver 
> works with a couple of MIDI  adapters and synthesizers from Roland, as you 
> can see at Clemens page: 
> http://www.informatik.uni-halle.de/~ladischc/usbmidid.html
> 
> We have also a report from Martin Langer, that his MK-249C USB MIDI keyboard 
> >from Evolution Electronics Ltd. works with the snd-usb-midi driver.
> http://www.evolution.co.uk/products/keyboards_01.htm
> 

Let's say, the time of a general midi-interface is over since USB is coming
more and more to the midi world! 

Do we need an usb-midi device matrix? Up to now we have not much devices, but 
the list is growing and alsa midi documents are rare. Perhaps we should 
change this situation and start with a small midi-matrix or a general
usb-matrix. 

It's just an idea. 

martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
