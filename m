From: Florian Schmidt <mista.tapas@gmx.net>
Subject: copy pcm plugin
Date: Wed, 28 Jan 2004 18:05:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040128180546.4cc88584.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi, as far as i understand it, the copy plugin does nothing but copy its
input to its output. I wonder if it would be easily possible to extend
this plugin to copy to multiple slave pcms. This way it would be
(easily?) possible to "distribute" a stereo signal to 4 or even 6
channels.

Any thoughts? Maybe i just misunderstood the pcm copy docs though..

Flo

-- 
signature :)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
