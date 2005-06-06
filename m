From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: unresolved symbol class_device_destroy,
 class_device_create - alsa-driver-1.0.9a on kernel 2.4
Date: Mon, 6 Jun 2005 08:59:38 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506060858380.4802-100000@studcom.urz.uni-halle.de>
References: <42A2E466.3080507@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A2E466.3080507@netvigator.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Raymond wrote:
> Are there any patch to fix the unresolved symbol ?
>
> snd.o: unresolved symbol class_device_destroy
> snd.o: unresolved symbol class_device_create

Fixed in CVS since Friday.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
