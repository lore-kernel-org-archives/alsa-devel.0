From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Aureal ALSA-kernel migration.
Date: Tue, 03 Feb 2004 01:17:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1075785474.21176.6.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
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
To: Takashi Iwai <tiwai@suse.de>, Openvortex <openvortex-dev@nongnu.org>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi this is a broadcast to all stations...

I think i finally got it. The definitive patch to migrate the Aureal
driver into the alsa-kernel path, and hopefully into kernel 2.6.

Download it at:
http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/aureal-alsakernel.patch.gz

If you find any problem, report as soon as possible.

NOTE: This is the "stable" branch. That means, no 3D audio for now.
Anyway thats pretty useless without the coming OpenAL ALSA back-end
rework.

Takashi,
Try out this patch, and tell me if it fits well.

Jeff,
I included your latest patch. Thank you very much !

Best Regards

Manuel Jander




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
