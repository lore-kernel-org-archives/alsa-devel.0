From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sequencer thread safe?
Date: Wed, 9 Mar 2005 17:36:44 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503091735080.20492-100000@studcom.urz.uni-halle.de>
References: <IUFqzjsU.1110385737.7697320.rcb.filter24@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <IUFqzjsU.1110385737.7697320.rcb.filter24@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rob Buse <rcb@filter24.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rob Buse wrote:
> I was just wondering if the sequencer api is thread safe?

The ALSA library is not thread safe.

> I was wondering why I never saw this behavior in the older
> library.

The haven't been any relevant changes.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
