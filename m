From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Soundcard matrix: removing some M-Audio USB devices
Date: Mon, 01 Mar 2004 18:04:04 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40437B14.7020702@superbug.demon.co.uk>
References: <20040229232621.GB10518@fliwatut.scifi> <404276D4.1010208@superbug.demon.co.uk> <20040301001027.GC10518@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040301001027.GC10518@fliwatut.scifi>
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
> James Courtier-Dutton hat gesagt: // James Courtier-Dutton wrote:
> 
> 
>>You will be lucky to find any sound card complying with the USB Audio 
>>spec, as the spec is written so badly.
> 
> 
> This is the USB spec I'm referring, not the USB AUDIO spec. Those
> M-Audio devices aren't even recognized as being USB devices by the
> kernel.
> 
> ciao

So "lsusb" gives no output for the device?
I have seen some usb devices that connect, and then for some reason the 
kernel does not like them, and disconnects them before you have a chance 
to see them in lsusb.

Which part of the USB spec do they break ?

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
