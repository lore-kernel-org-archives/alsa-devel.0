From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.7.1 against cvs head: please test it!
Date: Tue, 13 Jul 2004 22:06:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040713200625.GB18453@tuba.home>
References: <200407131155.43747.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200407131155.43747.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Werner Schweer <ws@seh.de>, Rui Nuno Capela <rncbc@rncbc.org>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 13, 2004 at 11:55:43AM +0200, Karsten Wiese wrote:
> Hi,
> 
> this module version sports "no sleeping" in ALSA's pcm START/STOP callbacks.
> It could need a little more testing, as the changes are many.
> Here it works well with kernels "planet CCRMA's 2.4.26" and "vanilla 2.6.7 all 
> debug flags I found enabled".

No problems on debian with 2.4.25-rc1 using an us122 :)


martin

-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
