From: "Sebastian H." <vand2@gmx.de>
Subject: Vertex distortion bug in xonotic
Date: Fri, 08 Apr 2011 22:36:20 +0200
Message-ID: <4D9F71C4.8030501@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id B9D12243F6
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 22:36:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello list

In the Mesa versions 7.9.2 - 7.10.2  I get strange triangle
distortion bugs in the game Xonotic. They don't appear in 7.8.2.

http://xwmw.org/misc/triangle_bug_01.jpg
http://xwmw.org/misc/triangle_bug_02.jpg


glxinfo | grep string

server glx vendor string: SGI
server glx version string: 1.2
client glx vendor string: Mesa Project and SGI
client glx version string: 1.4
OpenGL vendor string: X.Org R300 Project
OpenGL renderer string: Gallium 0.4 on ATI RV570
OpenGL version string: 2.1 Mesa 7.10.2
OpenGL shading language version string: 1.20


Regards,
Sebastian H.
