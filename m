From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: hdsp/firmware problem
Date: Fri, 14 Feb 2003 14:18:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030214131848.GA1586@finnendahl.de>
References: <20030214120658.GE1169@finnendahl.de> <E18jfEO-0007rb-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E18jfEO-0007rb-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

the driver/interface works. The guy in Rotterdam tried the line
outputs on the front (I realized that this might have been the reason
5 minutes after I posted my previous mail).

Since the hdsp code reports firmware load failure there still might be
something wrong, but the Multiface plays sound as it should :-).

--
Orm

Am Freitag, den 14. Februar 2003 um 07:46:09 Uhr (-0500) schrieb Paul Davis:
> >the hdsp driver still seems to have problems with the new pci
> >card. It's a little complicated for me to give exact information as
> >the machine is in Rotterdam and I'm in Berlin. I got The following
> >email from the sysadmin of the machine:
> 
> i have an hdsp-9652 here that i haven't installed yet. it sounds as if
> need to do so and test it out, because i think it has the new firmware
> on it. RME sent me one because to develop a firmware flasher is not
> safe on the pure hdsp - a mistake will fry the h/w. apparently the
> hdsp-9652 is resistant to such mistakes.
> 
> however, i can't do it today, that's for sure. i will ask RME though
> and see if they know of anything that i/we should know.
> 
> --p
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
> are you planning your Web Server Security? Click here to get a FREE
> Thawte SSL guide and find the answers to all your  SSL security issues.
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
