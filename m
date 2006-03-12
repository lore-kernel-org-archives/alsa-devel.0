From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Re: Reducing spam on alsa-devel
Date: Sun, 12 Mar 2006 00:18:33 -0700
Message-ID: <4413CB49.3090801@redfish-solutions.com>
References: <440F1811.8060900@redfish-solutions.com>	 <1141840298.767.163.camel@mindpipe>	 <440F1C8C.6090807@redfish-solutions.com>	 <2c746f620603111309v20e61acbs64feb02844334bdf@mail.gmail.com> <1142143510.25358.99.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98F651D8
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 08:18:36 +0100 (MET)
In-Reply-To: <1142143510.25358.99.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eric Shattow <lucent@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Sat, 2006-03-11 at 15:09 -0600, Eric Shattow wrote:
>
>>I agree that the spam level on alsa-devel is highly rediculous. I
>>
>>stopped reading it because i have to sift through too much
>>
>>non-content.
>>
>The spam has been drastically reduced from several months ago.  Maybe
>
>whatever filter was applied could be dialed up a bit?
>
>Do you notice any pattern in the spam scores (see headers) of the
>
>messages that get through?
>
>Lee
>
>  
>
For instance:

Mar 11 16:44:10 mail sendmail[4669]: NOQUEUE: connect from lists-outbound.sourceforge.net [66.35.250.225]

Mar 11 16:44:10 mail sendmail[4669]: k2BNiAP8004669: Milter (mimdefang): init success to negotiate

Mar 11 16:44:10 mail sendmail[4669]: k2BNiAP8004669: Milter: connect to filters

Mar 11 16:44:10 mail mimedefang.pl[4652]: relay: 66.35.250.225 => US

Mar 11 16:44:10 mail mimedefang.pl[4652]: helo: lists-outbound.sourceforge.net (66.35.250.225) said "helo lists-outbound.sourceforge.net"

Mar 11 16:44:10 mail mimedefang.pl[4652]: k2BNiAP8004669: sender: 66.35.250.225, lists-outbound.sourceforge.net "from <alsa-devel-admin@lists.sourceforge.net>"

Mar 11 16:44:10 mail sendmail[4669]: k2BNiAP8004669: from=<alsa-devel-admin@lists.sourceforge.net>, size=6407, class=-60, nrcpts=1, msgid=<200603112351.k2BNpo5Q009695@saturnfans.saturnfans.com>, proto=ESMTP, daemon=MTA-v4, relay=lists-outbound.sourceforge.net [66.35.250.225]

Mar 11 16:44:11 mail mimedefang.pl[4652]: k2BNiAP8004669: hits=7.437, req=5, names=HTML_50_60,HTML_MESSAGE,HTML_TEXT_AFTER_BODY,HTML_TEXT_AFTER_HTML,MIME_HEADER_CTYPE_ONLY,MIME_HTML_ONLY,NORMAL_HTTP_TO_IP

Mar 11 16:44:11 mail mimedefang.pl[4652]: MDLOG,k2BNiAP8004669,spam,17.437,66.35.250.225,<alsa-devel-admin@lists.sourceforge.net>,<philipp_subx@redfish-solutions.com>,[Alsa-devel] Important information regarding your Chase account

Mar 11 16:44:11 mail mimedefang.pl[4652]: filter: k2BNiAP8004669:  bounce=1 discard=1

Mar 11 16:44:11 mail mimedefang[11357]: k2BNiAP8004669: Bouncing because filter instructed us to

Mar 11 16:44:11 mail sendmail[4669]: k2BNiAP8004669: Milter: data, reject=554 5.7.1 Message rejected; scored too high on the Spam test.

Mar 11 16:44:11 mail sendmail[4669]: k2BNiAP8004669: to=<philipp_subx@redfish-solutions.com>, delay=00:00:01, pri=144407, stat=Message rejected; scored too high on the Spam test.



How did this one get through?

-Philip




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
