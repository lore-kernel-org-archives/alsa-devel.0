From: "Mark Knecht" <mknecht@controlnet.com>
Subject: MIDI timing question
Date: Wed, 27 Aug 2003 10:32:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGKEAEDBAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   Does anyone have a simple page I could read with an explanation about how
one would go about transmitting a given number of MIDI events at a known
tempo using the Alsa MIDI services? How does one transmit at 92bpm with say
16th note accuracy and really get the events to be timed correctly on the
bus?

   Is this possible to do totally within Alsa, or do developers have to
create their own time base and then every MIDI event just goes out raw?

   I understand there is possibly a 'sequencer' interface, but when I look
at the online Alsa documentation I seem to be missing it.

   Please keep any answers extremely simple. I'm just looking for a little
really basic education.

Thanks in advance,
Mark




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
