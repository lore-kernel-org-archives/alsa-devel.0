From: <jacqueslen@sympatico.ca>
Subject: yet another library question
Date: Thu, 4 Mar 2004 15:15:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040304201517.GNIA21160.tomts22-srv.bellnexxia.net@sympatico.ca>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've been told that meta events can't be handled by the sequencer, and thus midi doesn't have any mechanisms for creating them, apart from setting the tempo(I can understand this, since the sequencer doesn't care about lyrics or copyright). shouldn't the sequencer be able to handle a  "MIDI channel prefix" event? And shouldn't the sequencer know the time signature(I thought the time signature changed the way the music was played)
--Jacques


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
