From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Novation X-Station: mostly success, but...
Date: Thu, 17 Mar 2005 09:31:01 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503170930350.13179-100000@studcom.urz.uni-halle.de>
References: <200503170056.29280.wanthalf@centrum.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200503170056.29280.wanthalf@centrum.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pavel Vondricka <wanthalf@centrum.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pavel Vondricka wrote:
> However, I have problems with the "standard compliant" audio part: I can play
> sounds through the device, but I cannot capture them. No wonder: the mixer
> seems to have no effect on the device. There are just a few controls anyway:
> bass, treble, mic volume, speaker volume, aso. - nothing seems to have any
> effect when playing a sound through the device, just hardware volume knobs on
> it :-).

What is the output of "lsusb -v" for this device?


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
