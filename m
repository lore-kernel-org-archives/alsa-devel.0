From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Mo' better modem support
Date: Sat, 10 Sep 2005 17:49:39 +0300
Message-ID: <20050910144939.GB13534@tecr>
References: <s5h64tfs8wm.wl%tiwai@suse.de> <431D554E.8050500@netvigator.com> <20050906142917.GA30523@sashak.softier1.local> <431E3771.8090303@netvigator.com> <20050907064449.GA8391@titan.lahn.de> <431EBB71.3070206@netvigator.com> <20050907161011.GA11357@sashak.softier1.local> <4321ABFF.9090904@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4321ABFF.9090904@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 23:36 Fri 09 Sep     , Raymond wrote:
> 
> Do ALSA support Motorola SM56 MOT6269353 with Silicon DAA Si3014 ?

I guess that SM56 MOT6269353 is customized edition of Si3036, if so it
is supported.

> It seem that au8810 is connected to MOT6269353 on MDC of ASUS L8400B 
> notebook.

Yes, very possible and it looks like AC97 link. And if au8810 data
sheet is available we may to add support for this modem.

Sasha.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
