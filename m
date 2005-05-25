From: Lorenzo Milesi <lorenzo.milesi@gmail.com>
Subject: Problems with HDa
Date: Wed, 25 May 2005 09:44:24 +0200
Message-ID: <29c147bd05052500442c455d8@mail.gmail.com>
Reply-To: Lorenzo Milesi <lorenzo.milesi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi

A friend of mine has just bought a brand new Asus laptop, equiped with
an Intel 82801fb.
We're having lots of troubles with this card, and still we couldn't
get it working. We previously tried with azm module and then with alsa
1.0.9's hda driver. both modules load correctly, alsamixer works, but
absolutely no sound comes out from the speakers.
I was missing one thing: when loading the hda module it says:
hda_codec.c:512:
hda_codec.c: no AFG node found

Any help?
thanks
maxxer


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
