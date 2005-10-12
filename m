From: Andrew Gaydenko <a@gaydenko.com>
Subject: Re: bugtrack offline?
Date: Wed, 12 Oct 2005 17:40:03 +0400
Message-ID: <200510121740.03384@goldspace.net>
References: <dij20i$aj3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <dij20i$aj3$1@sea.gmane.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have the problem too (last traceroute strings are shown below). Sometimes (verys seldom)
I can access the host via my provider proxy, but never - via local own squid. I have reported
the problem to inway.net and have not got any answer yet.

Andrew
__________________________
...
20  212.24.132.158 (212.24.132.158)  101.933 ms  98.092 ms  99.579 ms
21  budejovice.inway.net (213.151.70.198)  115.436 ms  130.363 ms  116.341 ms
22  budejovice.inway.net (213.151.70.198)  623.096 ms !H  3106.950 ms !H  3104.940 ms !H


======= On Wednesday 12 October 2005 17:10, Jack Thomasson wrote: =======
for the last week i have been unable to reach bugtrack.alsa-project.org from
home or office.  here is a traceroute excerpt:

 8  nyk-bb2-pos7-1-0.telia.net (213.248.80.74)  82.385 ms   84.543 ms  
84.666 ms
 9  ldn-bb2-pos7-1-0.telia.net (213.248.65.93)  160.385 ms   161.565 ms  
168.761 ms
10  prs-bb2-pos6-0-0.telia.net (213.248.65.114)  174.333 ms   175.502 ms  
176.414 ms
11  ffm-bb2-pos6-0-0.telia.net (213.248.65.118)  190.535 ms   192.155 ms  
193.843 ms
12  prag-b2-pos3-0.telia.net (213.248.65.6)  213.102 ms   214.084 ms  
214.668 ms
13  dial-telecom-109772-prag-b2.c.telia.net (213.248.96.82)  181.794 ms  
183.050 ms   184.270 ms
14  inway-dial.inway.net (212.24.133.93)  316.076 ms   315.095 ms   314.051
ms
15  212.24.132.158  189.587 ms   195.963 ms   197.699 ms
16  budejovice.inway.net (213.151.70.198)  206.793 ms   207.495 ms   211.684
ms
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  budejovice.inway.net (213.151.70.198)(H!)  222.887 ms (H!)  222.113 ms
(H!)  221.626 ms

thanks in advance,

:{)}



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
