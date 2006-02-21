From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: Re: DMA strangeness?
Date: Tue, 21 Feb 2006 17:54:32 -0000 (GMT)
Message-ID: <55534.217.150.108.178.1140544472.squirrel@newgolddream.dyndns.info>
References: <1140361953.9117.9.camel@localhost.localdomain>
    <s5hlkw4ka19.wl%tiwai@suse.de>
    <49492.217.150.108.178.1140536595.squirrel@newgolddream.dyndns.info>
    <s5hd5hgk3fq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5hgk3fq.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 21 February, 2006 5:49 pm, Takashi Iwai wrote:

> If you set INTERLEAVED flag in the pcm hardware setting, it seems not
> matching with your hardware model.
>
>

Oddly, I set both. So I can fix that now. Not sure how I can execute two
DMA transfers though - ie one to the left buffer and one to the right.
Hmmm.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=3D=
121642
