From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: emu10k1 latency / capture period
Date: Thu, 17 Jun 2004 19:26:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406172326.i5HNQkQV017899@dhin.linuxaudiosystems.com>
References: <40D1E4E7.8000704@joe-job.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 17 Jun 2004 14:37:27 EDT."
             <40D1E4E7.8000704@joe-job.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alsa-devel@lists.sourceforge.net, pzad@pobox.sk
List-Id: alsa-devel@alsa-project.org

>To reiterate the situation:  currently the ASIO drivers for this card 
>provide an order of magnitude
>better latency than the ALSA driver.  I am constantly hearing claims 
>that ALSA is superior to ASIO,
>but no one can tell me why the ALSA drivers for this *very* common 
>device provide 5-10x worse latency
>than the ASIO drivers.
>
>As I see it, this is a glaring deficiency.

as a disinterested observer, i would just note that by my
understanding, Creative have not released all the necessary
programming information on the emu10k1. i suspect that whatever is
necessary to get the period size down to the levels the ASIO driver(s)
are using is in the information that they will not release without an
NDA. 

"freedom! my freedom! you got to give for what you take!"

--p


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
