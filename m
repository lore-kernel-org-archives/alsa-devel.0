From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: Tascam US-224/428 MMC?
Date: Tue, 20 Jul 2004 20:01:43 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32928.192.168.1.5.1090350103.squirrel@192.168.1.5>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93>   
    <7444.195.245.190.93.1090312112.squirrel@195.245.190.93>   
    <20040720180512.GA527@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040720180512.GA527@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, annabellesgarden@yahoo.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

Hi Martin,
>
> Well, my us122 has no controller stuff. I guess it's even impossible
> to fix this with a more advanced firmware;-) But, go ahead and improve
> things. Your code is always welcome, except Karsten has already solved
> it;-)

Have he?

>
> BTW: I'm still searching an us224 user who wants to try out a free
> firmware file ( http://www.langerland.de/us122/usx2y-fw-0.1b.tar.bz2 ).
> It works with us122/us428, but us224 is still untested.
>

It works on my us-224 too, just tested it with the bundled ld2-ezusb.hex
file, as I don't have as31 as required to make it.

At first glance, everything works (using alsa-driver/kernel as of cvs
20040713, where Karten's recent snd-usb-usx2y 0.7.1 patch is included).

Remember that you can always count on my for us-224 testing.

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org






-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
