From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-bt87x info for Voodoo TV 200
Date: Thu, 01 Jun 2006 08:42:18 +0200
Message-ID: <20060601064218.GA15572@turing.informatik.uni-halle.de>
References: <1148517014.4264.4.camel@miniwade.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <1148517014.4264.4.camel@miniwade.site>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Wade Berrier <wberrier@berrier.homelinux.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Wade Berrier wrote:
> Here's the info for: "Voodoo TV 200" (USA)
> 
> ALSA sound/pci/bt87x.c:830: unknown card 0x878-0x121a:0x3000, using
> default rate 32000
> 
> digital_rate other than 32000 didn't work (sounded like chipmunks).

This card has now been added to the driver's whitelist.


Thanks!
Clemens
