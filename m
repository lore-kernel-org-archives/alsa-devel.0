From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Print for tracing bugs
Date: Wed, 25 Jan 2006 13:19:43 +0000
Message-ID: <ad2655cb0601250519w71a16bccr@mail.gmail.com>
References: <200601231442.52366.gineera@aspect135.co.uk>
	 <1138034480.1354.30.camel@mindpipe>
	 <200601242129.25181.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_38768_307155.1138195183542"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200601242129.25181.gineera@aspect135.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_38768_307155.1138195183542
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 24/01/06, Alan Horstmann <gineera@aspect135.co.uk> wrote:
>
> On Monday 23 January 2006 16:41, you wrote:
> > Yes just add printk()'s to the driver code.
> >
> Thanks.  I can get these to print to var/log/messsages, but how do I get
> them
> to come immediately to a konsole?
>
> Alan
>
>
In the konsole type
tail -f /var/log/messages

As messages appear in the file, they will be displayed.

------=_Part_38768_307155.1138195183542
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 24/01/06, <b class=3D"gmail_sendername">Alan Horstmann</b> &lt;<a href=
=3D"mailto:gineera@aspect135.co.uk">gineera@aspect135.co.uk</a>&gt; wrote:<=
div><span class=3D"gmail_quote"></span><blockquote class=3D"gmail_quote" st=
yle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex=
; padding-left: 1ex;">
On Monday 23 January 2006 16:41, you wrote:<br>&gt; Yes just add printk()'s=
 to the driver code.<br>&gt;<br>Thanks.&nbsp;&nbsp;I can get these to print=
 to var/log/messsages, but how do I get them<br>to come immediately to a ko=
nsole?
<br><br>Alan<br><br></blockquote></div><br>In the konsole type<br>tail -f /=
var/log/messages<br><br>As messages appear in the file, they will be displa=
yed.<br><br>

------=_Part_38768_307155.1138195183542--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
