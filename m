From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [BUG] buggy ali5451 driver
Date: Tue, 05 Nov 2002 09:36:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m28z08mn05.fsf@vador.mandrakesoft.com>
References: <m24raxpndj.fsf@vador.mandrakesoft.com>
	<s5hu1ixa0eu.wl@alsa2.suse.de> <3DC68350.2040208@wanadoo.fr>
	<3DC68814.6070700@wanadoo.fr> <20021104112035.GA14883@dogsolitude.org>
	<3DC6903B.1070309@wanadoo.fr> <3DC69817.80300@wanadoo.fr>
	<20021104122851.GA15552@dogsolitude.org> <3DC6A0ED.6080202@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DC6A0ED.6080202@wanadoo.fr> (Olivier Ricordeau's message of
 "Mon, 04 Nov 2002 17:31:41 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olivier Ricordeau <olivier.ricordeau@wanadoo.fr>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Olivier Ricordeau <olivier.ricordeau@wanadoo.fr> writes:

> Hope it will help...
> Note that this is wat I got after a "normal" boot (no kernel option,
> dma still active).
> 
> It would be just great not to be obliged to install a window$ on this
> laptop... I've not used Microsoft's products for several months and I
> feel just fine with it! ;-)

since some bad interaction happens with eide disks, one thing that
could help would be to try 2.4.20-rc1 + alsa-0.9.0rc5 since alan cox
fixed ali eide controller driver.



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
