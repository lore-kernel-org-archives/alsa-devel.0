From: tom burkart <alsa@aussec.com>
Subject: Radio card and sound card?
Date: Wed, 30 Apr 2003 00:37:54 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304300026130.1205-100000@home.aussec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,
I have been asked by Innes Corp <http://www.innescorp.com.au/> to write
some drivers for their professional radio capture cards.

The real issue is as follows:  They are radio cards so really it should be
written as a V4L driver.  Yet they have only digital outputs (on the PCI
bus).  So they are really very fancy sound cards.
There is no single API that adequadely covers all aspects of their
operation.

What am I missing?  Any ideas on how to proceed?

tom.
Consultant

AUSSEC    Phone: 61 4 1768 2202
339 Blaxland Rd., Ryde NSW 2112



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
