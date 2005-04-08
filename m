From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Perl interface to alsalib MIDI?
Date: Fri, 8 Apr 2005 12:27:05 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504081152460.3042-100000@studcom.urz.uni-halle.de>
References: <1112952788.6701.231408303@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1112952788.6701.231408303@webmail.messagingengine.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dominic Espinosa <dcespin@fastmail.fm>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dominic Espinosa wrote:
> I have not been able to find any references to using perl with alsalib.

There is no Perl wrapper for ALSA.  I'm planning to write a SWIG
interface.

> Before I leap into perl-XS-land and write my own interface, I thought I
> would ask whether this is likely to work well in the first place.

Probably.  But you could just call amidi.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
