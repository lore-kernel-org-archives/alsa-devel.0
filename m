From: Gerhard Dirschl <gerhard.dirschl@gmx.de>
Subject: ICE1712: no volume range inversion for AK4528/4524
Date: Thu, 5 Dec 2002 22:26:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021205212655.GA2571@euh11a303.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

 Hi.

The volume range inversion is ok for the AK4529/Delta410 (to increase 
volume when pulling up the faders).
But AK4528 (and AK4524) don't need the inversion (sliders worked 
correctly before Jaroslav's patch).

Gerhard

-- 
Gerhard Dirschl
Karlsruhe


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
