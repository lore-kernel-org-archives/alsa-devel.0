From: kreuzritter2000@gmx.de
Subject: Re: EWS64XL: cs4232 alsa driver is no more  working with Alsa 0.9.0beta12 and Sam9407 driver , Alsa0.5.x worked fine
Date: Thu, 7 Mar 2002 17:28:09 +0100 (MET)
Message-ID: <14922.1015518489@www44.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from mx0.gmx.net (mx0.gmx.net [213.165.64.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA07211
	for <alsa-devel@alsa-project.org>; Thu, 7 Mar 2002 17:28:26 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Uros Bizjak <uros@kss-loka.si>
List-Id: alsa-devel@alsa-project.org

Hello,


>
>   For EWS64XL (at least for my rev 1.2) you should use cs4236. It worked
> for me a couple of weeks ago. In fact, you don't need to initialize
> a sam9407 device to use CoDec device with latest ALSA revision.
>
> 	Uros.
>

Thank you very much.
I will try that, hope it works.




>   BTW: I'm developing a driver for sam9407 device. I already can
> talk and receive responses from sam9407 chip, and PCM/mixer functions can
> easily be implemented now. I just returned from business trip, and I will
> try to hack on PCM/mixer functions soon.
>

That are really great news. :)
An alsa driver for the sam9407 device.
That's what i was waiting for a very long time.

Can't wait for beta testing them. :)
Thank's a lot for writing them.


Best Regards
 Oliver C.







-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
