From: "Ivica Bukvic" <ico@fuse.net>
Subject: What is the current status of the alsa sound server (signal polling)?
Date: Fri, 19 Apr 2002 01:51:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a9odn4$k4h$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all! A while ago I was inquiring about the current status of the
.asoundrc documentation, as well as the feasibility of creating "mock"
devices that would allow polling of the audio i/o resources of the
soundcard whose driver's limitations and/or hardware limitations
currently do not support hardware polling.

I am just wondering if anyone had any luck in figuring out how to do
that using .asoundrc and whether that is even possible at this point.

Also, what is the current status of gstreamer in this department and
jack? (I tried artsd and that one simply doesn't cut it)

Any info on this issue would be utmostly appreciated!

Ico
