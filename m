From: Koef <koef@notsupported.org>
Subject: Re: Running 32 bit apps under 64 bit kernel
Date: Tue, 12 Oct 2004 19:01:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012170116.GA23251@bukken.notsupported.org>
References: <20041012145657.GA22992@bukken.notsupported.org> <s5hmzysvuca.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hmzysvuca.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2004 at 05:17:57PM +0200, Takashi Iwai wrote:

> Koef wrote:
> > 
> > I have AMD64 machine running 64 bit 2.6.9-rc3 kernel. 64 bit sound apps run
> > fine, but 32 bit apps do not:
> 
> Did you snd-ioctl32?

Ah! So that's the magic word. I apologize for not finding this in the
documentation ;-) All is well now.

Thanks, Koef.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
