From: Anders Torger <torger@ludd.luth.se>
Subject: Re: RME96 patch broke
Date: Tue, 28 Jan 2003 22:14:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301282214.03185.torger@ludd.luth.se>
References: <200301281648.h0SGmnF87404@mail.mega.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301281648.h0SGmnF87404@mail.mega.nu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Pouzzner <douzzer@mega.nu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 28 January 2003 17.48, Daniel Pouzzner wrote:
> >so you have
> >tested with an old ALSA and the new driver (rme96.c) and that does
> > not work?
>
> Yuppers.  Pinned it down pretty carefully.
>
> >Is it double speed capture from analog, or from digital input you
> > are having problems with?
>
> Analog.  Haven't tested digital for the bug yet.

Uhm... I have some problems. It was ages ago I used the analog input, 
and now when I test it, I can't get it to work at all... All I get is 
noise. Could you confirm what does work with the analog input, even 
with the new driver? I suspect that my hardware is broken...

/Anders Torger


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
