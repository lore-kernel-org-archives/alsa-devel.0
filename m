From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Simple instruments broken?
Date: Tue, 23 Apr 2002 01:49:54 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020423014954.C2708@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Maybe a year ago I hacked together a mikmod driver for GUS synth. I
started with the drivers in alsamod and ultramod and I actually got
it to make sound. But somehow I misplaced the driver. So I started from
scratch after the sequencer API changes, but I couldn't get any sound from
it. Now I wanted to take another look to see if I could actually make it
work, but now it won't even compile. What's happened to the instrument
support stuff?

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
