From: jack christe <jack_alyz@yahoo.co.in>
Subject: complied error
Date: Sat, 8 Oct 2005 02:27:07 +0100 (BST)
Message-ID: <20051008012707.76091.qmail@web8608.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web8608.mail.in.yahoo.com (web8608.mail.in.yahoo.com [202.43.219.83])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A5EDA167
	for <alsa-devel@alsa-project.org>; Sat,  8 Oct 2005 03:27:09 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi=20
i got this error=20

whn i m running ./configure --with-cards=3Dazx
              gives=20
checking for which soundcards to compile driver for...
configure: error: Unsupported soundcard azx

thn i ran for all cards..

after..

 whn i m (make) compiling alsa-driver-1.0.8rc1=20
i got this error..
"/root/alsa-driver-1.0.8rc1/acore/init.c: In function
`snd_card_module_info_read':
/root/alsa-driver-1.0.8rc1/acore/init.c:526: error:
dereferencing pointer to incomplete type  "

so wht shld i do nxt????


OS - GENTOO , kernel 2.6.11, sound card =3D intel high
definition ....



	=09
__________________________________________________________=20
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.=
com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
