From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: [ANNOUNCE] aconnectgui
Date: Thu, 7 Mar 2002 12:23:58 +0100
Message-ID: <a67fne$4kp$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

"aconnectgui is a FLTK based frontend for aconnect. It is written
directly on top of the aconnect source, leaving the original source
intact, only adding a couple of ifdefs, and some calls to the gui
part, so it provides exactly the same functionality, but with a
graphical userinterface."

http://www.iua.upf.es/~mdeboer/

Note that this is a (quick) port to alsa 0.9.x . I wrote this originally
for alsa 0.5, when it was called aseqpatchbay. I currently don't have a
soundcard with any interesting MIDI devices, so I would apreciate if
you let me know if it works for you. The code needs to be cleaned up
and documented. Feel free to do this or make any other improvements
:-)

Maarten

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
