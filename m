From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Soundcard matrix: removing some M-Audio USB devices
Date: Sun, 29 Feb 2004 23:33:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <404276D4.1010208@superbug.demon.co.uk>
References: <20040229232621.GB10518@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040229232621.GB10518@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Frank Barknecht wrote:
> Hallo,
> 
> I'd like to propose changing the status of three M-Audio USB
> devices in the soundcard matrix to "unsupported on 2.6". The Quattro,
> Audiophile USB and reportedly the Duo all don't comply to the USB
> specification, as has been discussed here and on linux-usb-dev in the
> recent past.
> 
> Thus they are not useable on 2.6 kernels anymore and should be removed
> from the list of supported cards - or at least should have a red
> WARNING sticker applied. It would be - and already is - really anoying
> to someone who buys such a device and later finds out, that it is not
> supported, although the website say differently.
> 
> ciao

Frank,

You will be lucky to find any sound card complying with the USB Audio 
spec, as the spec is written so badly.

Cheers
James



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
