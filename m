From: "Ilya Konstantinov" <future@shiny.co.il>
Subject: Re: Plugin for amplifying microphone (software "mic
	boost")
Date: Thu, 11 Jan 2007 01:40:41 +0200
Message-ID: <490cd03c0701101540q2f5c889ai9a31ad8361db21f4@mail.gmail.com>
References: <490cd03c0701100224g11ad69a9ke3af48048504689b@mail.gmail.com>
	<s5h4pqzgoku.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1464593691=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4pqzgoku.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1464593691==
Content-Type: multipart/alternative;
	boundary="----=_Part_14069_25492883.1168472441390"

------=_Part_14069_25492883.1168472441390
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 1/10/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> OTOH, the route plugin supports amplifying, but it doesn't have
> dynamic volume controls.  If you need only fixed amplification, this
> should work.


Thanks guys. This indeed worked.

------=_Part_14069_25492883.1168472441390
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 1/10/07, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
OTOH, the route plugin supports amplifying, but it doesn&#39;t have<br>dynamic volume controls.&nbsp;&nbsp;If you need only fixed amplification, this<br>should work.</blockquote></div><br>Thanks guys. This indeed worked.<br>

------=_Part_14069_25492883.1168472441390--


--===============1464593691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1464593691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1464593691==--
