From: Richard Bown <bownie@bownie.com>
Subject: ALSA instrument API
Date: Thu, 4 Apr 2002 12:21:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204041124.AFF89495@msgdirector2.onetel.net.uk>
References: <20020404113042.02c1189a.mdeboer@iua.upf.es>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from msgdirector2.onetel.net.uk (IDENT:mirapoint@msgdirector2.onetel.net.uk [212.67.96.149])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA13403
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 13:24:47 +0200
In-Reply-To: <20020404113042.02c1189a.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks to Maarten I've got involved in implementing ALSA support for Rosegarden 4.
I've been browsing the ALSA API and patching together a driver layer to give us a
general framework we can share between ALSA and aRts.  The ALSA Instrument API looks
promising but so far I can't find much on it on the mailing list archive or on
the web.  Any clues for an overview?

We've got the beginnings of quite a sophisticated Instrument/Studio concept in the
pipeline similar to Logic's Environment and of course I'd like to make the most
of the driver features as flexibly as we can right from the start.

Cheers,
Richard Bown
-- 
http://www.all-day-breakfast.com/rosegarden
http://www.bownie.com
