From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Fw: writing audiowerk driver (philips saa7146a),
 some questions
Date: Fri, 31 May 2002 13:03:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205311259260.14881-100000@mailserver.intern.bfad.de>
References: <001801c2088f$71693120$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailserver.intern.bfad.de (mail.bfad.de [212.62.208.67])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA31789
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 13:03:42 +0200
In-Reply-To: <001801c2088f$71693120$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 31 May 2002, Martijn Sipkema wrote:

>  - does alsa allow varipitch? i think the new rme cards are supposed to
>  have this feature and the audiowerk8 has it, i.e. it can change its
> sampling
>  rate from about 37700 to 58200 hz while running in 1hz increments.
>  this allows for sync to video/tape/midi or whatever. or it allows for the
>  sample rate to be adjusted when receiving audio using rtp.

Can the frequency be changed without stopping (no loss of sound)? If so it is
an interesting feature, but I am not sure if supported by ALSA.

Best regards,
--
Tomasz Motylewski


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
