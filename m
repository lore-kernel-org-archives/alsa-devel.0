From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: snd-usb-audio problems with 2.6.18
Date: Sun, 24 Sep 2006 02:02:19 +0200
Message-ID: <20060924000219.GA4679@hardeman.nu>
References: <20060923125456.GA7757@hardeman.nu>
	<d9def9db0609230623k6ccfedbp1cd5be8ec25d176d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <d9def9db0609230623k6ccfedbp1cd5be8ec25d176d@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Markus Rechberger <mrechberger@gmail.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 23, 2006 at 03:23:19PM +0200, Markus Rechberger wrote:
>this issue might be hidden within the usb subsystem.
>USB bandwidth allocation doesn't work 100% yet afaik, better turn off
>support for it when configuring your kernel.

Thanks, turning off bandwidth allocation fixed usb-audio again

-- =

David H=E4rdeman

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
