From: Paul Davis <pbd@op.net>
Subject: Re: Rate Conversion
Date: Mon, 01 Jul 2002 07:51:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207011150.g61BoPr17354@post2.fast.net>
References: <3D1FBC14.359A637@anu.edu.au>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 01 Jul 2002 12:19:00 +1000."
             <3D1FBC14.359A637@anu.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: u9514439@anu.edu.au
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Apart from rates or 44.1 or 48kHz I was unable to find a rate/period
>size combination that I was able to use with plughw:0,0.

This is an error in alsa-lib as far as I can tell. its possible to set
the rate to 32kHz using the hardware device (for the Hammerfall) and
use it without a problem. I wish I could help you with the issue in
alsa-lib, but i don't understand it well enough nor do i have the time.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
