From: Daniel Haus <daniel.haus@vizarts.de>
Subject: Re: Plea to help save me from Windows !!!
Date: 21 Nov 2002 03:06:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1037844408.18971.12.camel@saturn>
References: <3DDC2F86.70102@tele-ip.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DDC2F86.70102@tele-ip.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bruce Paterson <bruce@tele-ip.com>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Behaviour:
> The output sound is perfect for about 2 minutes. After that every now 
> and then I get "distortion" in the audio. No xruns or errors are 
> reported in the software. It sounds like only part of the output buffer 
> is correct (the general gist is right, but there's crap and warbles 
> there as well).

this might not be caused by your app, this could be an alsa-problem.

i experienced such problems, too (i am using cs46xx). usually i am
runnigng xmms (with alsa-plugin) when it happens. i get a very "thin" 
sound - very little bass, volume goes down and i get some distortion.
alltogether it sounds like my speakers would be broken (they aren't,
really!).
i did not do any more testing, but about 24 hours ago i upgraded to
0.9.0-rc6 and had no problems since then, but that might not mean
anything ...

regards,
daniel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
