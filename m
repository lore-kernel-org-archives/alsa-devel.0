From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Interrupt handler
Date: 19 Mar 2003 09:38:03 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048066686.5765.2.camel@Jay>
References: <s5h1y16uphm.wl@alsa2.suse.de>
	<XFMail.20030317152245.pochini@shiny.it>  <s5hisugu7es.wl@alsa2.suse.de>
	<1048036537.7424.17.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048036537.7424.17.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> Look at the physical addresses. They're spaced by 4KB, but the periods
> are 11KB long and 11026*3<44100 !! You can imagine how beatiful sound I
> get... What am I missing ?

Ehm, I found the problem, ignore my previous msg.


Bye.




-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
