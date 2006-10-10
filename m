From: albox@free.fr
Subject: Re: Issue with Intel HDA Sound card 82801G (laptop
	Medion)
Date: Tue, 10 Oct 2006 02:15:14 +0200
Message-ID: <1160439314.452ae61245cdb@imp6-g19.free.fr>
References: <1160438676.452ae39456ad3@imp6-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160438676.452ae39456ad3@imp6-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tdavis@dsl-only.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I tried to compile the version included in the tarball that Remy posted last
weekend but I got some error messages :

/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.9b_25/a=
core/init.c:749:
error: field =91pdev=92 has incomplete type
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.9b_25/a=
core/init.c:762:
error: =91platform_bus_type=92 undeclared here (not in a function)
/home/albuntu/install/realtek-linux-audiopack-4.05b/alsa-driver-1.0.9b_25/a=
core/init.c:763:
warning: initialization from incompatible pointer type

Remy, which version of GCC did you use ?

Thanks

Al

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
