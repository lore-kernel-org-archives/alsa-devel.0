From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Support for the Bluetooth subband codec (SBC)
Date: Mon, 8 Nov 2004 13:40:07 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411081326500.2162@pnote.perex-int.cz>
References: <1099878354.6896.80.camel@pegasus>  <Pine.LNX.4.58.0411081155020.2162@pnote.perex-int.cz>
 <1099915747.6896.113.camel@pegasus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1099915747.6896.113.camel@pegasus>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Nov 2004, Marcel Holtmann wrote:

> I don't think that this is linear PCM, but actually I am no expert when
> it comes to codec specific stuff. I would be great if you can take a
> look at it and tell me what you think how we should support it.

I see - SBC is an audio compression. It should be implemented in alsa-lib 
as you suggested.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
