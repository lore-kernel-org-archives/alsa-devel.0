From: "CTAF ctaf" <goctaf@gmail.com>
Subject: Re: [PATCH] us428control support for mixxx
Date: Wed, 4 Oct 2006 19:04:27 +0200
Message-ID: <1a9cd1af0610041004r2d6b9416xce1cdbe65f65a08b@mail.gmail.com>
References: <1a9cd1af0609300906gc80abb2n492eac0ce1d1facd@mail.gmail.com>
	<s5hirj0jbt7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0162334234=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirj0jbt7.wl%tiwai@suse.de>
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

--===============0162334234==
Content-Type: multipart/alternative;
	boundary="----=_Part_86545_9633291.1159981467029"

------=_Part_86545_9633291.1159981467029
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

yes I will change the indent, and resend you the patch. Thanks for your code
review.

On 10/4/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Sat, 30 Sep 2006 18:06:53 +0200,
> CTAF ctaf wrote:
> >
> > This patch allow to change the mapping of the us428, the new mapping is
> used with
> > mixxx.
> > To use the new mapping:
> > ./us428control -m mixxx
> >
> > I already posted an older version on the bug tracker, but I had'nt have
> response for
> > it.
> > thanks.
> >
> > Signed-off-by: Cedric GESTES <goctaf@gmail.com>
>
> Thanks.  Through a quick look, the changes seem OK to me.
> But, could you fix the indent before merging to the tree?
> Karsten's original code uses 8-char tabs for indentation while you're
> using 2-chars.
>
>
> Takashi
>

------=_Part_86545_9633291.1159981467029
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

yes I will change the indent, and resend you the patch. Thanks for your code review.<br><br><div><span class="gmail_quote">On 10/4/06, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">At Sat, 30 Sep 2006 18:06:53 +0200,<br>CTAF ctaf wrote:<br>&gt;<br>&gt; This patch allow to change the mapping of the us428, the new mapping is used with
<br>&gt; mixxx.<br>&gt; To use the new mapping:<br>&gt; ./us428control -m mixxx<br>&gt;<br>&gt; I already posted an older version on the bug tracker, but I had'nt have response for<br>&gt; it.<br>&gt; thanks.<br>&gt;<br>&gt; Signed-off-by: Cedric GESTES &lt;
<a href="mailto:goctaf@gmail.com">goctaf@gmail.com</a>&gt;<br><br>Thanks.&nbsp;&nbsp;Through a quick look, the changes seem OK to me.<br>But, could you fix the indent before merging to the tree?<br>Karsten's original code uses 8-char tabs for indentation while you're
<br>using 2-chars.<br><br><br>Takashi<br></blockquote></div><br>

------=_Part_86545_9633291.1159981467029--


--===============0162334234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0162334234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0162334234==--
